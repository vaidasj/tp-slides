# Slides for Internet Technologies

## Tools Used

- node.js
- [markdown-to-slides](https://github.com/partageit/markdown-to-slides)
- [remark.js](https://github.com/gnab/remark)

## Installation

```shell
$ npm install markdown-to-slides -g
```

> the system should have _node.js_ installed

## Creating slide content

- Create a markdown file under `src` directory
- A specific subset of _remark.js_ syntax should be used: [The document mode](https://github.com/partageit/markdown-to-slides#the-document-mode-convert-markdown-documents-not-aimed-to-slides)
- Full _remark.js_ syntax can be found on their [wiki](https://github.com/gnab/remark/wiki)
- To add images to the slides just place image under `images` directory and refence it in the `.md` file like this:

 ```
 ![alt text](images/<file-name> "<title>")
 ```
 
- Check already created slides under `src` directory for examples

## Building HTML files

### Debugging

To debug how the slides look while writing them:

```shell
$ sh watch.sh src/<slide_name.md>
```

## Building

To rebuild all slides (output is put under `slides` directory):

```shell
$ sh build.sh
```

## Publishing

To upload slide in to remote server:

```shell
$ sh publish.sh
```