import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import tailwindcss from '@tailwindcss/vite'
import autoprefixer from "autoprefixer";

export default defineConfig({
    plugins: [RubyPlugin(), tailwindcss()],
    css: {
        preprocessorOptions: {
            scss: {
                api: 'modern-compiler',
            },
        },
        postcss: {
            plugins: [autoprefixer()],
        },
    },
    build: {
        outDir: 'public/vite',
        assetsDir: '',
        rollupOptions: {
            input: {
                application: './app/frontend/entrypoints/application.js',
            },
        },
        chunkSizeWarningLimit: 800,
        sourcemap: false,
    },
    appType: 'custom',
    server: {
        host: 'localhost',
        port: 3036,
        strictPort: true,
        open: true,
    },
})
