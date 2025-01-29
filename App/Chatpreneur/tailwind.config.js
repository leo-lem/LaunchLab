/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./templates/*.html"],
  theme: {
    screens: {
      xs: '400px',
      sm: '576px',
      md: '768px',
      lg: '992px',
      xl: '1200px',
      xxl: '1400px',
    },
    extend: {
      maxWidth: {
        sm: `${540 / 16}rem`,
        md: `${720 / 16}rem`,
        lg: `${960 / 16}rem`,
        xl: `${1100 / 16}rem`,
        xxl: `${1250 / 16}rem`,
      },
    },
  },
  plugins: [],
}

