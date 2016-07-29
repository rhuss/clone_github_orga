# Run with
#
#  docker run -t -v ~/.ssh:/root/.ssh -v $(pwd):/repos rhuss/git_clone_github_orga "fabric8-quickstarts"

FROM perl:5.20
VOLUME ["/repos"]
RUN cpanm install Pithub Git::Repository
COPY clone_github_orga.pl /
COPY startup.sh /
WORKDIR /repos
ENTRYPOINT [ "bash", "/startup.sh" ]
