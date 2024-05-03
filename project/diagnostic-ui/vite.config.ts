import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";

// https://vitejs.dev/config/
export default defineConfig({
  resolve: {
    alias: {
      "@components": "/src/components",
      "@pages": "/src/pages",
      "@assets": "/src/assets",
    },
  },
  plugins: [react()],
});
