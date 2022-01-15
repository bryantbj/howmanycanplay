module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    extend: {
      colors: {
        "slate": "#3d3d3d",
        "near-black": "#272727",
        "blackest": "#1c1c1c",
        "cream": "#F2F7F2",
        "yellow": "#F7B32B",
        "red": "#FF1654",
        "blue": "#247BA0"
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('daisyui')
  ],
}