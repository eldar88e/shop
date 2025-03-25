import { defineConfig } from 'vite';
import ViteRails from "vite-plugin-rails";
import tailwindcss from '@tailwindcss/vite';
import autoprefixer from "autoprefixer";

export default defineConfig({
    plugins: [tailwindcss(), ViteRails({
        envVars: { RAILS_ENV: "development" },
        envOptions: { defineOn: "import.meta.env" },
        fullReload: {
            additionalPaths: ["config/routes.rb", "app/views/**/*"],
            delay: 300,
        },
    })],
    css: {
        preprocessorOptions: { scss: { api: 'modern-compiler' } },
        postcss: { plugins: [autoprefixer()] },
    },
    build: { sourcemap: false },
})
