#!/usr/bin/perl

# cpanm install Pithub
# cpanm install Mozilla::CA

use Pithub;
use Data::Dumper;
use Git::Repository;

my $orga = shift @ARGV || "fabric8-quickstarts";
my $p = Pithub->new();
my $result = $p->repos->list( org => $orga );
while (my $row = $result->next) {
  my $name = $row->{name};
  if ( -d $name) {
    print "Pull $name\n";
    my $repo = Git::Repository->new(work_tree => $name, { quiet => 1 });
    $repo->run("pull");
    if ($? >> 8) {
      $repo->run("stash");
      $repo->run("pull");
      $repo->run("stash","pop");
    }
  } else {
    print "Clone $name\n";
    my $git_url = $row->{ssh_url};
    Git::Repository->run(clone => $git_url, $name, { quiet => 0 });
  }
}
