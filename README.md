# CHALDEAS
Bringing order to Fate/Grand Order

## License
BSD 3-Clause, see [LICENSE](https://github.com/jnbooth/chaldeas/blob/master/LICENSE).

## Getting Started
Install [Elm](https://guide.elm-lang.org/install.html) and [npm](https://www.npmjs.com/get-npm). The recommended development environment is [Visual Studio Code](code.visualstudio.com) with the [Elm IDE](https://marketplace.visualstudio.com/items/sbrink.elm) extension.

To run a local development instance of the site, use `npm run dev`. To publish the site, use `npm run publish`; this requires permission to access the [Surge](surge.sh) server host.

To test the database's information against [GrandOrder.Wiki](https://grandorder.wiki), run `npm run scrape`. The page will only work if you temporarily disable Cross-Origin security policies, which is easiest to do with a browser extension like [this one for Firefox](https://addons.mozilla.org/en-US/firefox/addon/cors-everywhere/) or [this one for Chrome](https://chrome.google.com/webstore/detail/allow-control-allow-origi/nlfbmbojpeacfghkpbjhddihlkkiljbi?hl=en).

## Skill Effects
Skill effects are enumerated at the top of [Model.Skill](src/Database/Skill.elm). If you aren't sure what an effect means, check its text description in [Class.Show](src/Class/Show.elm). Before adding a new skill effect, make sure it isn't already on the list.
