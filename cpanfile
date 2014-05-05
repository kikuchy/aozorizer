requires 'perl', '5.008001';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'LWP::UserAgent';
    requires 'HTML::TreeBuilder';
};

