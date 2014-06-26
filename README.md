# Soda

Soda is a blogging framework built on [Jekyll](http://jekyllrb.com/).

[Demo]( http://yimingtang.github.io/soda/)

## Running Locally

Soda runs on [Jekyll](https://github.com/jekyll/jekyll), a blog-aware, static site generator in Ruby. I'm using Ruby 2.1.1 locallly. You can run the site with:

```
$ cd path/to/soda
$ gem install bundler # if you haven't installed Bundler
$ bundle install
$ rake preview
```

Then open you web browser, visit `http://localhost:4000` to see it running. If you have problems getting it up and running, [open an issue](https://github.com/yimingtang/soda/issues/new).


## Configuration

All the stuff is placed in `_config.yml`. I've written plenty of comments there. Just fill in the blanks, run the site and see what happens.

**NOTE:** Jekyll won't regenrate the site after you change the `_config.yml`. Therefore, stop and restart the server.


## Blogging Basics

Blogging with Soda is pretty easy. All you need is to write posts and type a few built-in commands.

### Creating a new post

```
$ rake create_post[title]
```

It will create a markdown file under `_post/` directory with necessary front-matter variables. Now, go on writing your post.

### Generating Site

```
$ rake build
```

This rake task lets Jekyll build the static site. If you want to preview the site, just run:

```
$ rake preview
```

It will start a web server. The default server address is `http://localhost:4000`.

### Deployment

Currently, Soda uses [rsync](http://rsync.samba.org/) as a deployment method. You must edit the configuration part of the Rakefile to meet your needs. Afterwards, run:

```
$ rake deploy
```

#### Other Deployment Methods

Soda can be deployed in a large number of ways due to the static nature of the generated output. The main purpose of them is to put your output onto a web server directory. Since Soda is a Jekyll powered site framework, you can apply any deployment methods suitable for Jekyll. For more details, see the Jekyll [documentaion](http://jekyllrb.com/docs/deployment-methods/).


## Advanced Usage

### Assets

Soda uses [jekyll-assets](https://github.com/ixti/jekyll-assets), assets pipeline plugin for Jekyll, to manage its assets. If you are familiar with Rails, you must know what I'm talking about. With this poweful plugin, writing Soda becomes much easier. Have a look.

#### Stylesheets

Soda uses [SASS](http://sass-lang.com/) as it's CSS pre-compiler. It also uses an open-souce CSS authoring framework, [Compass](http://compass-style.org/). All the stylesheets are placed in `_assets/stylesheets/`.

Write your own CSS there. I'd like to see your awesome works.

#### Javascripts

There are 3 main Javascripts: jQuery.js, [FitVids.js](https://github.com/davatron5000/FitVids.js) and [Skrollr.js](https://github.com/Prinzhorn/skrollr).

* FitVids.js is a lightweight, easy-to-use jQuery plugin for fluid width video embeds.
* Skrollr.js is a stand-alone parallax scrolling library for mobile (Android + iOS) and desktop.

`app.js` is the js file for the whole site and `plugins.js` is where any jQuery plugins should be. Feel free to add your code.

#### Images

All the site related image content is placed under `_assets/images/`. You may want to use you own artworks. One thing you should beware of is that any images which appear in posts ought to be placed under `images/` directory or just URL links. Keeping the site content in `_post/` and `images` makes life easier.

**NOTE:** If you prefer putting your images under `_assets/images/` directory. Use the Liquid tag `{% image 'your-image.jpg' %}` or the corresponding filter `{{ 'your-image.jpg' | image }}` in your source files (either HTML or markdown file). To get the relative path, invoke `{% asset_path 'your-image.jpg' %}` or `{{ 'your-image.jpg' | asset_path }}`.

#### Fonts

The icon fonts are generated by [IcoMoon](http://icomoon.io/), an excellent site for building custom fonts. Feel free to replace them as you like.


### Templates

As a typical Jekyll site, all the layouts and html partials are in the right place. Have a try.


### Cover Images

Soda likes cover images. They are cool. Soda won't resize your image currently, so take image size into consideration. Neither too large nor too small.

## Credits

Soda is created by [Yiming Tang](https://twitter.com/yiming_t). It's built on [Jekyll](https://github.com/jekyll/jekyll), a blog-aware, amazing static site generator, without which Soda can't be here.

Soda is inspired by many websites, frameworks and themes. They are:

* [Roon](https://roon.io/) made by Drew Wilson and Sam Soffes.
* [Medium](https://medium.com/).
* [Octopress](https://github.com/imathis/octopress), a blogging platform for hackers, designed by Brandon Mathis.
* [Poole](https://github.com/poole/poole), the butler for Jekyll, designed by @mdo.
* [Casper](https://github.com/TryGhost/Casper), the default theme for [Ghost](http://github.com/tryghost/ghost/).

Soda also uses a lot of powerful Ruby gems and Jekyll plugins. I'd like to say thank you to all of the smart brains.

## License

The source code of Soda is released under the MIT License. See [LICENSE](https://github.com/yimingtang/soda/blob/master/LICENSE) for more information.

All image content that Soda uses remain copyright its original copyright holder.
