# SoutHACKton website

This is SoutHACKton's OLD website, kindly hosted by GitHub Pages.
It was built with [Octopress][]. We now operate Wordpress again, this
repository continues to exist for historical reasons, and because we're
hotlinking some images from it on the new blog.


# EVERYTHING BELOW HERE IS OLD AND SHOULD BE IGNORED

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
