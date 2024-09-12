/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./build/web/**/*.{html,js,jsp}"],
  theme: {
    extend: {
      colors: {
        'coffee': {
          200: '#eee1c4',
          500: '#dcb386',
          700: '#9e826c' //hover
        }
      },
      fontFamily: {
        'serif': "'Abril Fatface', serif"
      }
    },
  },
  plugins: [],
}

