#!/usr/bin/perl
use lib do {__FILE__ =~ /^(.*)[\/\\]/; ($1||'.').'/make-pl'};
use MakePl;
use MakePl::C;
use v5.38;

##### COMMAND LINE CONFIGURATION

my @compile = (qw(
    gcc -march=rv64gcv_zba_zbb_zbs_zicond_zfh -mno-relax
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
        '64ko',
        'rnda',
        'rndo',
        'rndu',
        'test',
    ],
    imps => [
        #'byte',
        #'byte_ia',
        #'byte_c',
        'glibc_2_39',
        'glibc_2_40',
        'e8m1_ia',
        'e8m1',
        'e8m1_2',
        'e8m2',
        'e8m4',
        'e8m8',
        'e8any_1_1',
        #'e8any_1_2',
        #'e8any_1_2_ia',
        #'e8any_1_3',
        #'e8any_1_4',
        #'e8any_1_4_ia',
        #'e8any_1_5',
        'e8conservative',
        #'e8conservative2',
        #'e8conservative3',
        #'e8conservative4',
        'e8progressive',
        #'e8progressive_ia',
        #'e8any_al',
        #'e8any_as',
        'e8any_al2',
        'e8any_as2',
        'e8any_as3',
        'e8any_as4',
        'e8any_as5',
        'e8any_as6',
        'e8any_as2_2sc',
        'e8any_as2_tl',
        'e8any_as2_noppy',
        'e8con_as2',
        'e8con_as3',
        'e8m8_as2',
        'dummy',
    ],
}, {
     # memcmp benchmarks are incomplete and highly provisional.
    name => 'memcmp',
    tasks => [
        'short',
        'med',
        'rndeq',
        'rndne',
        'test',
    ],
    imps => [
        'byte',
        'e8m1',
        'e8m8',
        'e8any',
        'e8conservative',
        'e8conservative_byte',
        'e8progressive',
        'e8radical',
        'e8hybrid',
        'e8hybrid_byte',
        'e8hybrid_byte2',
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
        #'addi',
        #'li',
        #'lic',
        #'lla',
        #'lga',
        #'lld',
        #'lld_no_overwrite',
        #'lla_mismatch',
        #'lui_ori',
        #'lui_slli',
        #'lui_and',
        #'lui_add',
        #'lui_and_addi',
        #'lui_lui_same',
        #'lui_lui',
        #'auipc_auipc',
        #'lui_auipc',
        #'auipc_lui',
        #'li_addi',
        #'li_addi_2',
        #'li_addi_3',
        #'li_addi_4',
        #'mul',
        #'mulh',
        #'mulw',
        #'mul_add',
        #'mul_addx2',
        #'mulwx2',
        #'mulx2',
        #'mulhx2',
        #'mulh_mul',
        #'mulh_mul_fusecheck',
        #'mul_mulh_fusecheck',
        #'div',
        #'div_par',
        #'div_rep',
        #'div_cancel',
        #'div_zero',
        #'div_small',
        #'div_medium',
        #'div_large',
        #'div_huge',
        #'divw',
        #'divw_b',
        #'div_mul',
        #'rem',
        #'div_rem',
        #'div_rem_fusecheck',
        #'fadds',
        #'faddd',
        #'fadds_subnorm',
        #'fadds_nan',
        #'fadds_rtz',
        'fmuls',
        'fmulsx2',
        'fmulsx3',
        'fmulsx4',
        #'fmuls_mul',
        'fmuld',
        'fmuldx2',
        'fmuldx3',
        #'fmuls_subnorm',
        #'fmuls_nan',
        'fmulh',
        #'fmuls_rtz',
        #'fdivs',
        #'fdivs_fdivs',
        #'fdivs_div',
        #'fdivd',
        #'fdivh',
        #'fdivd_h',
        #'fdivd_vfrec7',
        #'fsqrts',
        #'fsqrtd',
        #'fsqrth',
        #'long_adds',
        #'long_adds_misaligned',
        #'nop_100x1m',
        #'nope_100x1m',
        #'nopp_100x1m',
        #'b_untaken',
        #'b_untaken_inter',
        #'b_untaken_inter2',
        #'b_untaken_inter3',
        #'b_taken',
        #'b_taken_inter',
        #'b_taken_inter2',
        #'b_taken_inter3',
        #'b_taken_inter3_n1',
        #'b_taken_inter3_n2',
        #'b_taken_inter3_n3',
        #'b_taken_inter3_n4',
        #'select_cz',
        #'select_br',
        #'lbu_sb_by1f',
        #'lbu_sb_by2f',
        #'lbu_sb_by3f',
        #'lbu_sb_by4f',
        #'lbu_sb_by4n',
        #'lbu_sb_by4i',
        #'lbu_sb_by6f',
        #'lh_sh_by4f',
        #'lh_sh_by4n',
        #'lw_sw_by1c',
        #'lw_sw_by1l',
        #'lw_sw_by2c',
        #'lw_sw_by2l',
        #'lw_sw_by4c',
        #'lw_sw_by4l',
        #'lw_sw_by4n',
        #'ld_sd_by1c',
        #'ld_sd_by1l',
        #'ld_sd_by2c',
        #'ld_sd_by2l',
        #'ld_sd_by3c',
        #'ld_sd_by3l',
        #'ld_sd_by4c',
        #'ld_sd_by4l',
        #'ld_sd_by4c_ma',
        #'ld_sd_by4c_fusecheck',
        #'ld_sd_by2c_str',
        #'ld_sd_by2l_str',
        #'ld_sd_by4c_str',
        #'ld_sd_by4l_str',
        #'ld_sd_by1ca',
        #'ld_sd_by1cb',
        #'lw_addi_sw_by2c',
        #'ld_addi_sd_by1c',
        #'ld_addi_sd_by1l',
        #'ld_addi_sd_by2c',
        #'ld_addi_sd_by2l',
        #'ld_addi_sd_by4c',
        #'ld_addi_sd_by4l',
        #'ld_ori_sd_by1c',
        #'ld_ori_sd_by1l',
        #'ld_ori_sd_by2c',
        #'ld_ori_sd_by2l',
        #'ld_ori_sd_by4c',
        #'ld_ori_sd_by4l',
        #'ld_or_sd_by4l',
        #'ld',
        #'ldx2',
        #'sd',
        #'sdx2',
        #'ld_sd_sd',
        #'ld2_sd2',
        #'ld2_sd2_sd2',
        #'lw2_sw2',
        #'stfwd',
        #'stfwd_misalign',
        #'stfwd_smaller',
        #'stfwd_larger',
        #'stfwd_middle',
        #'stfwd_partial_a',
        #'stfwd_partial_b',
        #'stfwd_partial_c',
        #'stfwd_partial_d',
        #'stfwd_miss',
        #'stfwd_1betw',
        #'stfwd_1betw_miss',
        #'addr_inc',
        #'refcount',
        #'refcount_amo',
        #'refcount_n',
        #'refcount_amo_n',
        #'vle8_m1',
        #'vle8_m8',
        #'vse8_m1',
        #'vse8_m8',
        #'vl_vs_m1',
        #'vl_vs_m4',
        #'vl_vs_m8',
        #'vl_vs_parch',
        #'vl_vs_vs_m1',
        #'vl_vs_vs_m8',
        #'vl_vs_seq_m1',
        #'vl_vs_seq_m8',
    ],
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
            my $task_pattern = "src/$dom->{name}/task/$task.*";
            my $imp_pattern = "src/$dom->{name}/imp/$imp.*";
            my @src_task = glob($task_pattern);
            my @src_imp = glob($imp_pattern);
            @src_task or die "Couldn't find $task_pattern";
            @src_imp or die "Couldn't find $imp_pattern";
            my $flag = $task eq 'test' ? '-ggdb' : '-s';
            rule $exe, [@src_task, @src_imp], sub {
                ensure_path($exe);
                run @compile, $flag, @src_task, @src_imp, '-o', $exe;
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
        my $out = sprintf '%-20s ', uc($dom->{name});
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
