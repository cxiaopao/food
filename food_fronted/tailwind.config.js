/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
        colors: {
            dark: '#0C2D57',
            primary: '#FC6736',
            regular: '#EFECEC',
        }
    },
},
  plugins: [],
}

