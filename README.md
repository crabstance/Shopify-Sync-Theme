Shopify-Theme-Sync
==================

My setup for using the shopify theme sync tool found at github.com/davidmurdoch/shopify-theme-sync. The point of this script is to enable the use of git with shopify theme development. If you make a repo of your theme and then clone it to a DEV folder and a LIVE folder you can then target those folders with this script which will use Shopify Theme Sync to watch for changes to the theme and sync them with your dev or live server depending on which mode you're in. This allows for one to use git for branches and commits while developing a shopify theme on a dev store. When you are happy with the results push your changes to your repo, then set this script to live mode and pull your changes into your LIVE version which will then sync file changes to your LIVE server allowing you to have git like functionality while working with Shopify's mess of a system.


Requirements
============
* The shopify theme sync tool by David Murdoch must be installed and can be found here on github @ github.com/davidmurdoch/shopify-theme-sync
* An API/APP key for your shopify account
* The ID number for the theme you will be syncing with
 

Installation
============
* Clone and install Shopify Theme Sync and any of its dependencies from github.com/davidmurdoch/shopify-theme-sync
* Create a repo of the shopify theme you wish to work on
* Create a branch for this repo using **git branch branch-name** to sit on that isn't master to avoid conflicts later, it can be anyting, i use "temp"
* Check out this new branch using **git checkout branch-name** so when we push from our other repos we don't get errors
* Clone this repo to two folders, name them DEV and LIVE for now using **git clone --local ~/path/to/local/repo/folder/ ~/path/of/destination/folde**
* Visit your shopify admin for your live site and go to the theme settings page, in the address bar there will be an ID number that coresponds to your theme for example "shop-name.myshopify.com/admin/themes/**8202365**/settings"
* Rename your LIVE theme folder to the ID number you just found in the address bar of your live site
* Repeat this step for your DEV shop and your DEV folder so when you're done your live and dev theme folders are named after their coresponding IDs on their corresponding sites so the DEV shop ID should be used as the name of your DEV folder and the Live ID used for the name of your LIVE theme folder
* To make things easier make symlinks of these folders with normal names like "dev-them" and "live-theme", symlinks can be made using **ln -s /path/of/folder/or/file /path/of/where/you/want/link**


*You should now have two repos that both correspond to a local Origin repo on your machine. Each of these repos should be theme folders named after the appropriate theme ID taken from your DEV and LIVE sites. These folders containing our repo of files should be in the same folder, i usually name this folder themes for simplicity's sake.*

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
 
Workflow
========
* Start Shopify Theme Sync with this script by typing **shopify-sync-theme.sh --dev** this will begin syncing your dev theme with your dev site
* Navigate your terminal to the DEV folder
* Make changes as seen fit to DEV folder contents
* Review your changes on your dev site
* Add your changes to git with 
* When satisfied with your changes commit your changes to your repo with *git commit*
* Push your changes to your local origin repo with **git push origin branch-name**
* Stop Shopify Theme Sync by CTRL+C in terminal it's running
* Restart Shopify Theme Sync with **shopify-sync-theme.sh --live** to begin syncing to your live server
* Navigate your terminal to the LIVE folder
* Pull your changes to this repo with **git pull origin branch-name** and Shopify Theme Sync will sync changes to your live server

EOF
