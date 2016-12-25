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
      });
  }
};


cwpNotification.ports.loadMoreNotifications.subscribe(() => {
  notificationFeed.get({ limit:10 })
    .then(({ results }) => {
      cwpNotification.ports.notifications.send(
        results.map(r => ({
          id: r.activities[0].id,
          message: r.activities[0].message,
          isSeen: r.is_seen,
          isRead: r.is_read,
        }))
      )
    })
    .catch(reason => { console.error(reason); });
})