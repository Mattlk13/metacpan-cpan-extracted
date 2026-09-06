#!/usr/bin/env perl

# Play select tablas phrases in real-time
# Example(s):
# perl rt-tabla.pl synth 200

# Note that this code ignores the duration part of the note
# spcifications, so far.

use v5.36;
use Array::Circular ();
use Data::Dumper::Compact qw(ddc);
use MIDI::RtMidi::FFI::Device ();
use MIDI::RtMidi::Util qw(out_port stop_device);
use Music::Percussion::Tabla ();
use IO::Async::Loop ();
use IO::Async::Timer::Periodic ();

my $port = shift || 'synth'; # MIDI device
my $bpm  = shift || 300; # beats-per-minute

my $channel = 0; # yes, the notes of Tabla.sf2 are on channel 0.

my $beats = 16; # beats in a phrase
my $divisions = 4; # divisions of a quarter-note into 16ths
my $clocks_per_beat = 24; # PPQN
my $clock_interval = 60 / $bpm / $clocks_per_beat; # time / bpm / ppqn
my $ticks = 0; # clock ticks
my $beat_count = 0; # how many beats?
my @queue; # priority queue for note_on/off messages

my $midi_out = out_port($port);
say "Sending MIDI to $port at $bpm BPM";
# $midi_out->start;

$SIG{INT} = sub { 
    say "\nStop";
    stop_device($midi_out);
    exit;
};

my @bols = (
    ['ta', 'ke'],
    'ge',
    'ke',
    'ta',
    ['ge', 'ke'],
    'dha',
);
my $bols = Array::Circular->new(@bols);

my $t = Music::Percussion::Tabla->new(
  signature => '3/4',
  bars      => 64,
  bpm       => 320,
);

my $loop = IO::Async::Loop->new;

my $timer = IO::Async::Timer::Periodic->new(
    interval => $clock_interval,
    on_tick  => sub {
        $midi_out->clock;
        $ticks++;
        if ($ticks % $clocks_per_beat == 0) {
            my $spec = $t->strike($bols->next)->[0];
            push @queue, @$spec > 2 ? [ @{$spec}[1,2] ] : $spec->[1];
            for my $note (@queue) {
                if (ref $note eq 'ARRAY') {
                    say "N: @$note";
                    on($midi_out, $note->[0]);
                    on($midi_out, $note->[1]);
                }
                else {
                    say "N: $note";
                    on($midi_out, $note);
                }
            }
            $beat_count++;
        }
        else {
            # drain the queue and send note_off msgs
            while (my $note = pop @queue) {
                if (ref $note eq 'ARRAY') {
                    off($midi_out, $note->[0]);
                    off($midi_out, $note->[1]);
                }
                else {
                    off($midi_out, $note);
                }
            }
        }
    },
);

$timer->start;
$loop->add($timer);
$loop->run;

sub on ($midi_out, $note, $channel=0, $velo=127) {
    $midi_out->note_on($channel, $note, $velo);
}

sub off ($midi_out, $note, $channel=0, $velo=0) {
    $midi_out->note_off($channel, $note, $velo);
}