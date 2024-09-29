/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./build/web/**/*.{html,js,jsp}"],
  theme: {
    extend: {
      colors: {
        'coffee': {
          200: '#eee1c4',
          300: '#FFE0B5',
          500: '#dcb386',
          700: '#AF8260' //hover
        }
      },
      fontFamily: {
        'sans': "'Roboto Mono', sans",
        'serif': "'Abril Fatface', serif"
      }
    },
  },
  plugins: [],
}

