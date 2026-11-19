"""Steam Store Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Discounted specials and new releases in the UK
run = client.actor("Turboextract/steam-games-prices").call(run_input={
    "storeLists": [
        "specials",
        "new_releases"
    ],
    "country": "gb",
    "onlyOnSale": True
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("name"), item.get("price"), item.get("discountPercent"), item.get("developers"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
