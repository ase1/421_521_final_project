import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;
List<Status> tweets;

int tweetnum;
String myTweet;
boolean tweetIsGood;
String myQuery;

void setup()
{
  myQuery = "from:Inspire_Us";
  println(getATweet(myQuery,true));
  
  myQuery = "from:WSJ";
  println(getATweet(myQuery,false));
  
  myQuery = "microcontroller";
  println(getATweet(myQuery,true));
}

void getNewTweets(String myQuery)
{
  try
  {
      Query query = new Query(myQuery);
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
    getNewTweets(myQuery);
    delay(30000);  //get new tweets every 30 seconds
  }
}

String getATweet(String query, boolean isFiltered)
{
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("0Tmzx9UE87VeBZBUO7opb1LrL");
  cb.setOAuthConsumerSecret("lVXCemEC2OcUnEOb37dyfGl4bSNHeaRLbSZrRDZqK4LOGFwCP8");
  cb.setOAuthAccessToken("1636426622-R16coyljuFLDlJwPfGBqlsEWR1jbEXtXZJQa6C8");
  cb.setOAuthAccessTokenSecret("0XUKsVDrAFIHXo8ksmt8lQkr3tbT4KW1ufMeUQjD6hcwc");
  TwitterFactory tf = new TwitterFactory(cb.build()); 
  twitter = tf.getInstance();
  getNewTweets(query);
  thread("refreshTweets");
  tweetIsGood = false;
  tweetnum=0;
  while(!tweetIsGood)
  {
    Status status = tweets.get(tweetnum);  //get latest tweet
    myTweet = status.getText();  // the content from the tweet
    if(isFiltered && (myTweet.indexOf("http")!=-1 || myTweet.indexOf("RT")!=-1))  //filters bad tweets out
    {
      tweetnum++;
      //println("bad tweet: " + myTweet);
    }
    else tweetIsGood = true;
  }
  return myTweet;
}