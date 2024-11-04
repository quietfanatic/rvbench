#!/usr/bin/perl
use lib do {__FILE__ =~ /^(.*)[\/\\]/; ($1||'.').'/make-pl'};
use MakePl;
use MakePl::C;
use v5.38;

##### COMMAND LINE CONFIGURATION

my @compile = (qw(
    gcc -march=rv64gcv_zba_zbb_zbs_zicond -mno-relax
    -mno-riscv-attribute),'-Wl,--build-id=none',qw(
    -static -nostartfiles -nolibc -nostdlib
    -O3
)); # -O3 doesn't matter for assembly but we may have a bit of C here and there

my @domains = ({
    name => 'memcpy',
    tasks => [
        'three',
        '16a',
        '32a', '32s', '32u',
        '64a',
        '128a',
        '256a',
        '2ka', '2ks', '2ku',
        '64ka',
        'rnd',
        'test',
    ],
    imps => [
        #'byte_c',
        #'byte_ialign',
        #'byte_no_ialign',
        'e8m1_ialign',
        'e8m1_no_ialign',
        'e8m2',
        'e8m4',
        'e8m8',
        'e8any_1_1',
        'e8any_1_2',
        'e8any_1_2_ialign',
        'e8any_1_3',
        'e8any_1_4',
        'e8any_1_4_ialign',
        'e8con',
        'e8prog',
        'e8prog_ialign',
        'glibc_2_39',
        'glibc_2_40',
        'dummy',
    ],
}, {
    name => 'misc',
    tasks => [
        'once',
        #'alt',
        #'test',
    ],
    imps => [
        'li',
        'lla',
        'lga',
        'lld',
        'lld_no_overwrite',
        'lla_mismatch',
        'lui_slli',
        'nop_100x1m',
        'nope_100x1m',
        'nopp_100x1m',
        'loadstore_by1la',
        'loadstore_by1lb',
        'loadstore_by1lr',
        'loadstore_by1ca',
        'loadstore_by1cb',
        'loadstore_by1cr',
        'loadstore_by2la',
        'loadstore_by2ca',
        'loadstore_by3la',
        'loadstore_by3ca',
        'loadstore_by4la',
        'loadstore_by4ca',
    ]
});

sub ensure_path {
    if ($_[0] =~ /^(.*)\//s) {
        -d $1 or do {
            require File::Path;
            File::Path::make_path($1);
        }
    }
}

for my $dom (@domains) {
    for my $task (@{$dom->{tasks}}) {
        for my $imp (@{$dom->{imps}}) {
            my $exe = "out/$dom->{name}/$task/$imp";
            my $src_task = "src/$dom->{name}/task/$task.s";
            my $pattern = "src/$dom->{name}/imp/$imp.*";
            my @src_imp = glob($pattern);
            @src_imp or die "Couldn't find $pattern";
            my $flag = $task eq 'test' ? '-ggdb' : '-s';
            rule $exe, [@src_imp, $src_task], sub {
                ensure_path($exe);
                run @compile, $flag, @src_imp, $src_task, '-o', $exe;
                 # -mno-riscv-attributes doesn't seem to work
                if ($flag eq '-s') {
                    run 'strip', '--remove-section=.riscv.attributes', $exe;
                }
            }, {fork=>1};
            my $stat = "$exe.stat";
            if ($task eq 'test') {
                rule $stat, $exe, sub {
                    my $err = system($exe);
                    splat $stat, $err ? 'fail' : 'pass';
                }
            }
            else {
                rule $stat, $exe, sub {
                    run qw(perf stat -x | -o), $stat, $exe
                };
            }
            push @{$dom->{exes}}, $exe;
            push @{$dom->{stats}}, $stat;
        }
    }
    phony "out/$dom->{name}/build", $dom->{exes};
    phony "out/$dom->{name}/stats", $dom->{stats}, sub {
        my $out = sprintf '%-20s  ', uc($dom->{name});
        for my $task (@{$dom->{tasks}}) {
            $out .= sprintf ' %5s', $task;
        }
        say $out;
        say '-' x (21 + 6 * @{$dom->{tasks}});
        for my $imp (@{$dom->{imps}}) {
            $out = sprintf '%20s:', $imp;
            for my $task (@{$dom->{tasks}}) {
                my $stat = "out/$dom->{name}/$task/$imp.stat";
                my $data = slurp($stat);
                chomp $data;
                if ($task eq 'test') {
                    $out .= sprintf ' %5s', $data;
                }
                else {
                    $data =~ /\n(\d+)\|\|cycles:u\|/ or die ": Couldn't parse $stat\n";
                    my $cycles = $1;
                     # Round down because there's an overhead of about 1m cycles
                    $out .= sprintf ' %5d', int($cycles / 1000000);
                }
            }
            say $out;
        }
    };

    phony "out/$dom->{name}/clean_stats", [], sub {
        unlink glob "out/$dom->{name}/*/*.stat";
    };
}

phony 'stats', [map "out/$_->{name}/stats", @domains];

phony 'clean_stats', [map "out/$_->{name}/clean_stats", @domains];

phony 'clean', [], sub {
    require File::Path;
    File::Path::remove_tree('tmp');
    File::Path::remove_tree('out');
};

defaults 'stats';

make;
