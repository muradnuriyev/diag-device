/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      backgroundImage: {
        background: "url('./assets/background.jpg')",
      },
      colors: {
        main: {
          cream: "#D9E6FA",
          DEFAULT: "#B6D3FB",
          blue: "#0e4b76",
        },
      },
    },
  },
  plugins: [],
};


