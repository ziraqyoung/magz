const colors = require('tailwindcss/colors')

module.exports = {
  purge: [
    "./app/views/**/*.erb",
    "./app/javascript/stylesheets/**/*.scss",
    "./app/javascript/controllers/**/*.js",
    "./app/helpers/**/*.rb"
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      gray: colors.blueGray,
      indigo: colors.indigo,
      red: colors.red,
      yellow: colors.yellow,
      pink: colors.pink,
      rose: colors.rose,
      lime: colors.lime,
      green: colors.emerald,
      teal: colors.teal,
      purple: colors.purple,
      cyan: colors.cyan,
      blue: colors.blue,
      orange: colors.orange,
      amber: colors.amber,
      violet: colors.violet,
      fuchsia: colors.fuchsia,

    },
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/aspect-ratio"),
  ],
};
