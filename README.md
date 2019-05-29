# Fuitter

Convert Fb page to website for small businesses.

# Pre requisite

- Postgresql > 9.2
- Yarn
- Nodejs
- ruby 2.5.3

# Installation

- Clone the repo
- Run `bundle install`
- Run `yarn install`
- Copy `database.yml.sample` and rename it to `database.yml`
- Change credentials in database.yml
- Copy `.env.sample` and rename it to `.env`
- Run `rake db:create && rake db:migrate`
- Run `foreman start`

# Adding Templates

Create a directory inside `views/templates/`. Your template directory name should be written in small case. Inside your template directory, create a meta data file `fuitter.json`.

```
{
  "name": "your template name in small case. It should match the name of your template directory",
  "image": "preview image url",
  "properties": {
    "you can add any custom properties here that you will need in your template. For eg, slider,etc"
  }
}
```

Your template will need a layout file.So create a folder inside `views/layouts/templates/<your_template_name.html.slim>`. Generally, this file will contain the header and the footer with the ability to dynamically load the body part of the website.

Inside your `views/templates/<your_template_directory>`, add your html.slim files. You need to strictily name your files `about.html.slim`, `contact.html.slim`, `events.html.slim`, `events.html.slim`, `gallery.html.slim`, `home.html.slim`, `news.html.slim`, `photos.html.slim`

Your javascript and css for the template should reside in `app/javascript/templates/<your_template_directory>`. In case of css, create a `styles` folder, for js create `js` folder, for images create `images` folder inisde the directory.

You need to link your files to your html so you need to create another directory inside `app/javascript/packs/templates/<your_template_directory>/<name.js>` file. You will need to import your css files and images and your javascript files into this file.


# Save Template

You need to run `rake templates:sync` to list your templates in the web ui.

# Custom Fuitter Class

When you use the editor to change the font color it will look for `fuitter-color` . It only updates the color if it finds that class.
