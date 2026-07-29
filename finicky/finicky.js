export default {
  defaultBrowser: "Firefox",
  options: {
    hideIcon: false,
    keepRunning: true,
  },
  handlers: [
    {
      match: (url) => url.hostname === "meet.google.com",
      browser: "Google Chrome",
    },
  ],
};
