import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;
String searchString;
List<Status> tweets;

int currentTweet;
String myTweet;

void setup()
{
    //size(800,600);

    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("0Tmzx9UE87VeBZBUO7opb1LrL");
    cb.setOAuthConsumerSecret("lVXCemEC2OcUnEOb37dyfGl4bSNHeaRLbSZrRDZqK4LOGFwCP8");
    cb.setOAuthAccessToken("1636426622-R16coyljuFLDlJwPfGBqlsEWR1jbEXtXZJQa6C8");
    cb.setOAuthAccessTokenSecret("0XUKsVDrAFIHXo8ksmt8lQkr3tbT4KW1ufMeUQjD6hcwc");

    TwitterFactory tf = new TwitterFactory(cb.build());

    int i = 0; // set the query (like choosing a button)
    
    if(i==0) searchString = "from:Inspire_Us";
    else if (i==1) searchString = "from:WSJ";
    else if (i==2) searchString = "toaster";
    else searchString = "";
    
    twitter = tf.getInstance();

    getNewTweets();

    currentTweet = 0;

    thread("refreshTweets");
    
    Status status = tweets.get(0);  //get latest tweet
    
    myTweet = status.getText();
    println(myTweet);
    if(myTweet.indexOf("http")==-1 && myTweet.indexOf("RT")==-1)
    {
      
    }
}

void draw()
{
    
}

void getNewTweets()
{
    try
    {
        Query query = new Query(searchString);

        QueryResult result = twitter.search(query);

        tweets = result.getTweets();
    }
    catch (TwitterException te)
    {
        System.out.println("Failed to search tweets: " + te.getMessage());
        System.exit(-1);
    }
}

void refreshTweets()
{
    while (true)
    {
        getNewTweets();

        //println("Updated Tweets");

        delay(30000);  //get new tweets every 30 seconds
    }
}