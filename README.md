#Feature Walkthrough

Starting from [the home page](http://remus.herokuapp.com/):

![Home Page](http://i.imgur.com/4dYbpWr.png)

From here the first thing to do is create an account. Click "Sign Up" to get to the registration page:

![Signup Page](http://i.imgur.com/8FF9Nkl.png)

I used Devise to run my user accounts, which provides great functionality very simply and easily.

Once signed up you'll be returned to the home page, which will now include lists of the games for which you are the Game Master (GM) and the games where you're a player (empty for a new account):

![Signed In Home Page](http://i.imgur.com/EPdUpM4.png)

From here you can choose an existing galaxy to view or create a new one.

![New Galaxy Form](http://i.imgur.com/19uYF3k.png)

The galaxy creation form allows you to name your galaxy and choose how many rings of systems you want it to contain. Clicking the Create Galaxy button will take you back to the home page, from which you can click your new galaxy to view its map:

![Galaxy Map Page](http://i.imgur.com/V7ZlPyL.png)

Each galaxy comprises a set of randomly generated systems, linked up semi-randomly to allow travel between them. I designed the generation algorithm from scratch (fine-tuning it is on the agenda for later updates) and drew the map using SVG.

To view the people playing in this galaxy and add new ones click the Factions Present link at the bottom left to see the galaxy's Faction List:

![Faction List](http://i.imgur.com/uo0pNRV.png)

To start with there's only the default faction controlled by the GM (you) that gets automatically created with the galaxy. To add players to your game, click the Add New Faction link:

![New Faction Form](http://i.imgur.com/XVcWGc0.png)

You can enter a name for the new faction and choose a user to control it.

Now that you have someone playing your game, let's give them a system to control and some units to move around. Click the link back to the map of your galaxy. From there, click the name of any system to see the details of that system:

![System Details Page](http://i.imgur.com/sgSwPlB.png)

Here you can see the name of the system, who controls it, its characteristics, the nearby systems it's connected to, and the units present. Let's give control of the system to the faction we just created. Click the Edit This System link:

![Edit System Form](http://i.imgur.com/O0XTHG6.png)

Choose the faction you added from the Controlling Faction drop-down. While we're here, give them some Census (population) and Infrastructure so they can start earning income. Saving your changes will take you back to the system's page:

![Updated System Details Page](http://i.imgur.com/4PO0WJz.png)

Next, let's add some units. In the create unit form on the bottom right, choose the faction you want the new unit to belong to and enter a name for it. Click the button and the unit will appear. Click it again to make another:

![System Details Page With Units](http://i.imgur.com/LIOvsZX.png)

I used jQuery to sent AJAX requests for unit creation (and deletion) to create the units without refreshing the whole page. It took some effort to get it working right but it makes the interface feel smoother.

Now lets give our new units orders to move to another system. Since you're the GM, you can order the units around even if you don't control them. Click the Issue Move Orders button right below the list of units:

![Unit Orders Form](http://i.imgur.com/13g3ER5.png)

Choose a system to send the units to and click the Issue Orders button:

![System Details Page With Units With Destinations](http://i.imgur.com/PxYyvIV.png)

The units now know their destination, but they haven't gone anywhere yet. It's a turn based game; nothing will happen until the turn is resolved. To do this, go back to the galaxy map and click the Resolve Next Turn button on the bottom right. This will move all units to their destination. Check the system you ordered the ships to move to and you should see they've arrived.

Resolving the turn also includes population growth, so if you added some Census to a system, there might be more now. Each Census only has a 10% chance of reproducing though, so don't be surprised if it takes a couple turns to notice any growth.

[![Build Status](https://travis-ci.org/psgoodman/Project-Remus.svg?branch=master)](https://travis-ci.org/psgoodman/Project-Remus) [![Code Climate](https://codeclimate.com/github/psgoodman/Project-Remus.png)](https://codeclimate.com/github/psgoodman/Project-Remus) [![Coverage Status](https://coveralls.io/repos/psgoodman/Project-Remus/badge.svg)](https://coveralls.io/r/psgoodman/Project-Remus)
