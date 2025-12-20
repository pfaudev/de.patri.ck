<?php header("Content-type: text/css"); ?>

:root {
  --bs-blue: #0d6efd;
  --bs-indigo: #6610f2;
  --bs-purple: #6f42c1;
  --bs-pink: #ff0180;
  --bs-red: #dc3545;
  --bs-orange: #fd7e14;
  --bs-yellow: #ffc107;
  --bs-green: #198754;
  --bs-teal: #20c997;
  --bs-cyan: #0dcaf0;
  --bs-black: #000;
  --bs-white: #fff;
  --bs-gray: #6c757d;
  --bs-gray-dark: #232323;
  --bs-gray-100: #f8f9fa;
  --bs-gray-200: #e9ecef;
  --bs-gray-300: #dee2e6;
  --bs-gray-400: #ced4da;
  --bs-gray-500: #adb5bd;
  --bs-gray-600: #6c757d;
  --bs-gray-700: #495057;
  --bs-gray-800: #343a40;
  --bs-gray-900: #212529;
  --bs-primary: #0d6efd;
  --bs-secondary: #6c757d;
  --bs-success: #198754;
  --bs-info: #0dcaf0;
  --bs-warning: #ffc107;
  --bs-danger: #dc3545;
  --bs-light: #f8f9fa;
  --bs-dark: #232323 !important;
  --bs-primary-rgb: 13, 110, 253;
  --bs-secondary-rgb: 108, 117, 125;
  --bs-success-rgb: 25, 135, 84;
  --bs-info-rgb: 13, 202, 240;
  --bs-warning-rgb: 255, 193, 7;
  --bs-danger-rgb: 220, 53, 69;
  --bs-light-rgb: 248, 249, 250;
  --bs-dark-rgb: 33, 37, 41;
  --bs-white-rgb: 255, 255, 255;
  --bs-black-rgb: 0, 0, 0;
  --bs-body-color-rgb: 33, 37, 41;
  --bs-body-bg-rgb: 255, 255, 255;
  --bs-font-sans-serif: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", "Noto Sans", "Liberation Sans", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
  --bs-font-monospace: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
  --bs-gradient: linear-gradient(180deg, rgba(255, 255, 255, 0.15), rgba(255, 255, 255, 0));
  --bs-body-font-family: var(--bs-font-sans-serif);
  --bs-body-font-size: 1rem;
  --bs-body-font-weight: 400;
  --bs-body-line-height: 1.5;
  --bs-body-color: #212529;
  --bs-body-bg: #fff;
  --bs-border-width: 1px;
  --bs-border-style: solid;
  --bs-border-color: #dee2e6;
  --bs-border-color-translucent: rgba(0, 0, 0, 0.175);
  --bs-border-radius: 0.375rem;
  --bs-border-radius-sm: 0.25rem;
  --bs-border-radius-lg: 0.5rem;
  --bs-border-radius-xl: 1rem;
  --bs-border-radius-2xl: 2rem;
  --bs-border-radius-pill: 50rem;
  --bs-link-color: #0d6efd;
  --bs-link-hover-color: #0a58ca;
  --bs-code-color: #d63384;
  --bs-highlight-bg: #fff3cd;
}

html { scroll-behavior: smooth; }

body {
  width: 100vw;
  height: 100vh;
}

@media(max-width: 575px) {
  .border-top { border-top: 1px solid #424242; }
  .border-left { border-left: 1px solid #424242; }
  .border-bottom { border-bottom: 1px solid #424242; }
  .border-right { border-right: 1px solid #424242; }
  .border-top-0 { border-top: none!important; }
  .border-left-0 { border-left: none!important; }
  .border-bottom-0 { border-bottom: none!important; }
  .border-right-0 { border-right: none!important; }
}

@media(min-width: 576px) {
  .border-sm-top { border-top: 1px solid #424242; }
  .border-sm-left { border-left: 1px solid #424242; }
  .border-sm-bottom { border-bottom: 1px solid #424242; }
  .border-sm-right { border-right: 1px solid #424242; }
  .border-sm-top-0 { border-top: none!important; }
  .border-sm-left-0 { border-left: none!important; }
  .border-sm-bottom-0 { border-bottom: none!important; }
  .border-sm-right-0 { border-right: none!important; }
}

@media(min-width: 768px) {
  .border-md-top { border-top: 1px solid #424242; }
  .border-md-left { border-left: 1px solid #424242; }
  .border-md-bottom { border-bottom: 1px solid #424242; }
  .border-md-right { border-right: 1px solid #424242; }
  .border-md-top-0 { border-top: none!important; }
  .border-md-left-0 { border-left: none!important; }
  .border-md-bottom-0 { border-bottom: none!important; }
  .border-md-right-0 { border-right: none!important; }
}

@media(min-width: 992px) {
  .border-lg-top { border-top: 1px solid #424242; }
  .border-lg-left { border-left: 1px solid #424242; }
  .border-lg-bottom { border-bottom: 1px solid #424242; }
  .border-lg-right { border-right: 1px solid #424242; }
  .border-lg-top-0 { border-top: none!important; }
  .border-lg-left-0 { border-left: none!important; }
  .border-lg-bottom-0 { border-bottom: none!important; }
  .border-lg-right-0 { border-right: none!important; }
}

@media(min-width: 1200px) {
  .border-xl-top { border-top: 1px solid #424242; }
  .border-xl-left { border-left: 1px solid #424242; }
  .border-xl-bottom { border-bottom: 1px solid #424242; }
  .border-xl-right { border-right: 1px solid #424242; }
  .border-xl-top-0 { border-top: none!important; }
  .border-xl-left-0 { border-left: none!important; }
  .border-xl-bottom-0 { border-bottom: none!important; }
  .border-xl-right-0 { border-right: none!important; }
}

header {
  width: 100%;
  position: relative;
  height: 5dvh;
  top: 0%;
  margin: 0 auto;
}

.pp-content {
  width: 100%;
  height: calc(100dvh - 8dvh - 50px);
  margin: 0 auto;
  overflow-y: auto;
}

footer {
  position: absolute;
  width: 100%;
  height: 3dvh;
  margin: 0 auto;
}

footer .pp-inner {
  background: #232323;
  color:#ffffff;
  text-align: right;
  padding: 1% 2%;
}

.rechts { text-align: right!important; }
.links { text-align: left !important; }
.mittig { margin: 0 auto; text-align: center !important; }

.music-note { color:#ff0180; font-style: bolder; }
.nav-item { border-bottom: 1px solid #b0b0b0; }

.pp-weiss { color: var(--bs-white) !important; }
.pp-pink { color: var(--bs-pink) !important; }
.pp-rot { color: var(--bs-red) !important; }
.pp-gruen { color: var(--bs-green) !important; }
.pp-blau { color: var(--bs-blue) !important; }
.pp-black { color: var(--bs-black) !important; }
.pp-indigo { color:var(--bs-indigo) !important; }
.pp-lila { color:var(--bs-purple) !important; }
.pp-orange { color:var(--bs-orange) !important; }
.pp-gelb { color:var(--bs-yellow) !important; }
.pp-teal { color:var(--bs-teal) !important; }
.pp-cyan { color:var(--bs-cyan) !important; }
.pp-grau { color:var(--bs-gray) !important; }
.pp-dunkelgrau { color:var(--bs-gray-dark) !important; }
.pp-hellgrau { color:var(--bs-gray-300) !important; }

.pp-breadcrumb-links {
  width: calc(50% - 25px);
  text-align: left;
  float: left;
}

.pp-breadcrumb-rechts {
  width: calc(50% - 25px);
  text-align: right;
  float: right;
}

.pp-rating { width: 100%; }

.pp-rating > * { float: right; }

.pp-rating label {
  height: 1vh;
  width: 1vw;
  position: relative;
  cursor: pointer;
  padding: 0 5px;
}

.pp-rating label:nth-of-type(5):after { animation-delay: 0.5s; }
.pp-rating label:nth-of-type(4):after { animation-delay: 0.4s; }
.pp-rating label:nth-of-type(3):after { animation-delay: 0.3s; }
.pp-rating label:nth-of-type(2):after { animation-delay: 0.2s; }
.pp-rating label:nth-of-type(1):after { animation-delay: 0.1s; }

.pp-rating label:after {
  transition: all 1s ease-out;
  position: absolute;
  content: "☆";
  color: #e0e0e0;
  font-size: 45px;
}

.pp-rating input { display: none; }

.pp-rating input:checked + label:after, .pp-rating input:checked ~ label:after {
  content: "★";
  color: gold;
  text-shadow: 0 0 10px gold;
}

.pp-hilfe-item {
  margin-bottom:15px;
  border: 1px solid black;
  padding: 10px 15px;
}

.pp-hilfe-head {
  padding: 5px 0;
  border-bottom: 1px solid black;
}

.pp-hilfe-body {}
