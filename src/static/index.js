// pull in desired CSS/SASS files
require( './styles/main.scss' );
var stream = require('getstream');
var $ = jQuery = require( '../../node_modules/jquery/dist/jquery.js' );           // <--- remove if jQuery not needed
require( '../../node_modules/bootstrap-sass/assets/javascripts/bootstrap.js' );   // <--- remove if Bootstrap's JS not needed 

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
var cwpNotification = Elm.Main.embed( document.getElementById( 'main' ) );
window.cwpNotification = cwpNotification;

let client, notificationFeed;

cwpNotification.controller = {
  authenticate: ({authTokenUrl, appKey, appId, userId}) => {
    const url = authTokenUrl + "?userId=" + userId;
    fetch(url)
      .then(result => result.json())
      .then(({ token }) => {
        client = stream.connect(appKey, null, appId);
        notificationFeed = client.feed('notification', userId, token);
        loadMoreNotifications();
        notificationFeed
          .subscribe(result => {
            loadMoreNotifications();
            // if (result.new.length > 0) {
            //   loadMoreNotifications();
            // }
            // if (result.deleted.length > 0) {
            // }
          })

      });
  },
  hide() {
    cwpNotification.ports.setVisibility.send(false);
  },
  show() {
    cwpNotification.ports.setVisibility.send(true);
  }
};

const loadMoreNotifications = () => {
  notificationFeed.get({ limit: 100 })
    .then(({ results }) => {
      console.log('results', results);
      cwpNotification.ports.notifications.send(
        results.map(notificationResultToNotification)
      )
    })
    .catch(reason => { console.error(reason); });    
}

cwpNotification.ports.loadMoreNotifications.subscribe(loadMoreNotifications);

const notificationResultToNotification = result => ({
  id: result.activities[0].id,
  message: result.activities[0].message,
  isSeen: result.is_seen,
  isRead: result.is_read,  
});

cwpNotification.ports.markOneNotificationAsSeen.subscribe(notificationId => {
  notificationFeed
    .get({ mark_seen: [notificationId] })
    .then(loadMoreNotifications)
    .catch(reason => { console.error(reason); });
});