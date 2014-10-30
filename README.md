Shopify-Theme-Sync
==================

My setup for using the shopify theme sync tool found at github.com/davidmurdoch/shopify-theme-sync


Requirements
============
* The shopify theme sync tool by David Murdoch must be installed and can be found here on github @ github.com/davidmurdoch/shopify-theme-sync
* An API/APP key for your shopify account
* The ID number for the theme you will be syncing with
 

Installation
============
* Clone and install Shopify Theme Sync and any of its dependencies from github.com/davidmurdoch/shopify-theme-sync
* In the folder you installed Shopify Theme Sync, rename config-example.json to config.json
* Create and edit **config.dev.json** in the same folder as config.json and put your **dev shop name**, **dev shop API key**, **dev shop API password** and the file path for your local copy of the **dev** theme you're syncing

**Your file should look like this:**

    {
            "shops": [
    
                    {
    
                            "name": "your-DEV-shop-name-here",
                            "apiKey": "your DEV API key here",
                            "password": "your DEV password here",
                            "directory": "\/path\/to\/folder\/containing\/dev\/theme\/folder"
                    }

            ]
    }

*Make sure that you point the "directory" parameter at the folder that contains your theme folder not the theme folder itself.*

* Create and edit **config.live.json** in the same folder as config.json and put your **shop name**, **shop API key**, **shop API password** and the file path for your local copy of the **live** theme you're syncing

**Your file should look like this:**

    {
            "shops": [
    
                    {
    
                            "name": "your-shop-name-here",
                            "apiKey": "your DEV API key here",
                            "password": "your DEV password here",
                            "directory": "\/path\/to\/folder\/containing\/live\/theme\/folder"
                    }

            ]
    }

* Download Shopify-Sync-Theme.sh from this repo or clone this repo
* Make the script executable with **chmod +x /path/to/Shopify-Sync-Theme.sh**
* Start syncing to your **DEV site** with *shopify-sync-theme.sh --dev*
* Start syncing to your **LIVE site** with *shopify-sync-theme.sh --live*
