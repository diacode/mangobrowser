# MangoBrowser
MangoBrowser is a Sinatra web application that allows you to
easily browse [MangoPay's API](http://docs.mangopay.com/).

![ScreenShot](https://raw.githubusercontent.com/diacode/mangobrowser/master/screenshots/login.jpg)

More screenshots [here](https://github.com/diacode/mangobrowser/tree/master/screenshots).

MangoBrowser idea and code is inspired by [BrowS3](https://github.com/tractical/brows3), an Amazon S3 API explorer, crafted by [Tractical](http://tractical.com).

## How does it work?
The app will ask you for your Client ID and Client Passphrase and if those credentials are for preproduction or production mode. Don't worry, no information is kept in any
database.

Once logged in you will be able to see the list of users and events. Inside each User and Event you can navigate to their associated objects (Wallets, Transactions, Refunds, Transfers, etc.)

## Deploy to heroku with one click
You can deploy this app to your Heroku account for free by just pressing this button:
[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Installing
1. Install Ruby. You can use [rbenv](https://github.com/sstephenson/rbenv) or
any [other method](http://www.ruby-lang.org/en/downloads/) you prefer.

2. Install Node.js. You can see the official documentation [here](http://nodejs.org/download/)

3. Clone the repository

        $ git clone git@github.com:diacode/mangobrowser.git

4. Run bundle to install the required gems.

        $ bundle install

5. Run the application.

        $ rackup config.ru

6. Open your browser http://localhost:9292


## Contributing
You can see the contributing guidelines
[here](https://github.com/diacode/mangobrowser/blob/master/CONTRIBUTING.md)

## Disclaimer
MangoBrowser is not an official product by MangoPay. We created MangoBrowser to cover our own needs.
