// Steam Store Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Games for several niche keywords
const run = await client.actor('Turboextract/steam-games-prices').call({
    "searchTerms": [
        "roguelike",
        "city builder",
        "cozy farming"
    ]
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.name, item.price, item.discountPercent, item.developers);
}
