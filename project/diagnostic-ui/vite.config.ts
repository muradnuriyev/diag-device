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
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          react: ["react", "react-dom"],
          recharts: ["recharts"],
          chartjs: ["chart.js", "react-chartjs-2"],
        },
      },
    },
    chunkSizeWarningLimit: 1024,
  },
});
