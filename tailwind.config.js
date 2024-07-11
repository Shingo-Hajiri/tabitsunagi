module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'base-orange': '#fff8eb',
        'main-orange': '#ffb83d',
        'accent-blue': '#3d98ff'
      },
      animation: {
        "tracking-in-expand-fwd-bottom": "tracking-in-expand-fwd-bottom 1.0s cubic-bezier(0.215, 0.610, 0.355, 1.000)   both"
    },
    keyframes: {
        "tracking-in-expand-fwd-bottom": {
            "0%": {
                "letter-spacing": "-.5em",
                transform: "translateZ(-700px) translateY(500px)",
                opacity: "0"
            },
            "40%": {
                opacity: ".6"
            },
            to: {
                transform: "translateZ(0) translateY(50px)",
                opacity: "1"
            },
        },
      },
    },
  },
  plugins: [require("daisyui")]
}
