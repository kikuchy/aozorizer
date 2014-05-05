use strict;
use warnings;
use LWP::UserAgent;
use HTML::TreeBuilder;
use File::Temp 'tempfile';
use Encode 'encode';
use utf8;

# AozoraEpub setting
my $aozora_epub_class_name = 'AozoraEpub3';

# user agent setting
my $user_agent = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.63 Safari/537.36";

sub get_novel_text {
    my ($url) = @_;
# get target HTML source
    my $tree = HTML::TreeBuilder->new_from_url($url);
# pick up novel content
    my $novel_title = $tree->look_down('class', 'userdata')->look_down('class', 'title')->as_text;
    my @novel_authors = $tree->look_down('class', 'userdata')->look_down('class', 'name')->find('a');
    my $novel_author = $novel_authors[0]->as_text;
    my $novel_text = convert_notation_pixiv_aozora($tree->look_down('id', 'novel_text')->as_text());
    my $content = <<"CONTENT";
$novel_title
$novel_author


$novel_text
CONTENT
    return encode 'Shift_JIS', $content;
}

sub text_to_tempfile {
    my ( $text ) = @_;
    my ($fh, $filename ) = tempfile(SUFFIX => ".txt");
    print $fh $text;
    close $fh;
    return $filename;
}

sub convert_notation_pixiv_aozora {
    my ( $raw ) = @_;
    $raw =~ s/\[newpage\]/［＃改ページ］/g;
    $raw =~ s/\[chapter:(.+?)\]/［＃２字下げ］$1［＃「$1」は中見出し］/g;
    return $raw;
}

my $url = $ARGV[0];
print "loading novel from $url\n";

my $rawfile = text_to_tempfile(get_novel_text($url));
print "converting...\n";

my $status_code = system "java -cp AozoraEpub3.jar AozoraEpub3 -ext .kepub.epub -d ./ $rawfile";
print "exit with status code: $status_code\n";

