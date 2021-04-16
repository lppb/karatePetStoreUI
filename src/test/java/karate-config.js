function fn() {
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  var env = karate.env; // get java system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'test';
  }
  var config = {
    baseUrl: 'https://www.demoblaze.com/'
  }
  if (karate.env == 'ci') {
    karate.configure('driverTarget', { docker: 'ptrthomas/karate-chrome' });
  }
  else if (karate.env == 'test') {
    karate.configure('driverTarget', { docker: 'ptrthomas/karate-chrome', secComp: 'src/test/java/chrome.json', vncPort: 5900 });
  }
  return config;
}