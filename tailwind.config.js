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
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' }
        },
        moveInDown10: {
          '0%': { transform: 'translateY(-10%)' },
          '100%': { transform: 'translateX(0)' }
        },
        moveInDownFull: {
          '0%': { transform: 'translateY(-100%)' },
          '100%': { transform: 'translateX(0)' }
        },
        moveInUp10: {
          '0%': { transform: 'translateY(10%)' },
          '100%': { transform: 'translateX(0)' }
        },
        moveInUpFull: {
          '0%': { transform: 'translateY(100%)' },
          '100%': { transform: 'translateX(0)' }
        },
        moveInLeft10: {
          '0%': { transform: 'translateX(10%)' },
          '100%': { transform: 'translateX(0)' }
        },
        moveInLeftFull: {
          '0%': { transform: 'translateX(100%)' },
          '100%': { transform: 'translateX(0)' }
        },
        moveInRight10: {
          '0%': { transform: 'translateX(-10%)' },
          '100%': { transform: 'translateX(0)' }
        },
        moveInRightFull: {
          '0%': { transform: 'translateX(-100%)' },
          '100%': { transform: 'translateX(0)' }
        },
      },
      animation: {
        showDown: 'fadeIn .25s ease-out, moveInDown10 .25s ease-out',
        showUp: 'fadeIn .25s ease-out, moveInUp10 .25s ease-out',
        moveInDownFull: 'moveInDownFull .5s ease-out',
        moveInUpFull: 'moveInUpFull .5s ease-out',
        moveInLeftFull: 'moveInLeftFull .5s ease-out',
        moveInRightFull: 'moveInRightFull .5s ease-out',
      }
    },
  },
  plugins: [],
}

