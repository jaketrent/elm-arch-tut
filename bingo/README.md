# Buzzword Bingo in Elm

## Project Structure

This is an incomplete project used as a starting point.

All of the Elm code lives in `Bingo.elm` and `BingoUtils.elm`.

This project is designed for version 0.15.1 of the Elm Platform and relies on the [elm-html](http://package.elm-lang.org/packages/evancz/elm-html/3.0.0/) and [start-app](http://package.elm-lang.org/packages/evancz/start-app/1.0.0/) packages. 

The `index.html` file embeds the program as a fullscreen app and includes
the necessary JavaScript (`bingo.js`) and CSS stylesheet (`style.css`).

## Build Instructions

Run the following command from the root of this project:

```
elm make Bingo.elm --output bingo.js
```

Then open `index.html` in your browser!

## Copyright

This software is Copyright (c) 2015 The Pragmatic Studio
(pragmaticstudio.com), unless otherwise marked. Software from
other projects are subject to the license(s) appropriate to those
projects. You are responsible for complying with licenses for
software you use.

## License

If you have purchased the Pragmatic Studio's "Elm: Building Reactive 
Web Apps" video tutorial, we grant you permission to use this software and 
associated documentation files (the "Software") for your personal 
educational purposes only, including the rights to use and modify the 
Software subject to the following conditions:

- You may not use this Software to create training material,
  courses, books, articles, and the like.

- You many not sell, distribute, or publish this Software.

Please contact us if you are in doubt.

## Warranty

This Software is provided for educational purposes only, and comes
with absolutely no warranty. We make no guarantees that this code
is fit for any purpose.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
