# SoutHACKton website

This is SoutHACKton's website, kindly hosted by GitHub Pages. It's
currently built with [Octopress][].

## How can I contribute?

*TODO: Make this easier!*

To get up and running:

    git clone git@github.com:SoutHACKton/southackton.github.com.git
    cd southackton.github.com
    git checkout source
    rvm rubygems latest
    gem install bundler
    bundle install

**NOTE**: As we rely on Octopress, you may need to follow [their
instructions][Octopress instructions].

To view your changes as you make them (via a web browser):

    rake preview

To publish:

    rake generate
    rake deploy

[Octopress]: http://octopress.org/
[Octopress instructions]: http://octopress.org/docs/setup/
