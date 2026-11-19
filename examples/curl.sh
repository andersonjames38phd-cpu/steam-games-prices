#!/usr/bin/env bash
# Steam Store Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~steam-games-prices"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Discounted specials and new releases in the UK (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "storeLists": [
      "specials",
      "new_releases"
    ],
    "country": "gb",
    "onlyOnSale": true
  }'

# 2. Games for several niche keywords (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "searchTerms": [
      "roguelike",
      "city builder",
      "cozy farming"
    ]
  }'

# 3. Prices for specific games (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "appIds": [
      "730",
      "https://store.steampowered.com/app/1145360/"
    ],
    "includeDescription": true
  }'
