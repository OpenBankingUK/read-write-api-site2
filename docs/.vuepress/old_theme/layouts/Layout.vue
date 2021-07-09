<template>
  <div>
    <!-- <p>HEADER NOW</p>
    <ReadWriteApiSitePluginHeader></ReadWriteApiSitePluginHeader>-->
    <!-- <SearchBox /> -->
    <Layout>
      <!-- https://github.com/vuejs/vuepress/blob/master/packages/%40vuepress/theme-default/layouts/Layout.vue#L22 -->
      <!-- <SearchBox slot="page-top"></SearchBox> -->
      <!-- <Header slot="page-top"></Header> -->
      <Footer slot="page-bottom"></Footer>
      <!-- <SearchBox #page-top></SearchBox> -->
      <!-- <Footer #page-bottom></Footer> -->
    </Layout>
  </div>
</template>

<script>
import Layout from '@parent-theme/layouts/Layout.vue';
import Navbar from '@parent-theme/components/Navbar.vue';
// https://github.com/vuejs/vuepress/blob/master/packages/%40vuepress/theme-default/components/Navbar.vue#L33
import SearchBox from '@SearchBox';
import Header from '@theme/components/Header.vue';
import Footer from '@theme/components/Footer.vue';

export default {
  components: {
    Layout,
    Navbar,
    SearchBox,
    Header,
    Footer,
  },
  mounted() {
    console.log('this.$site.themeConfig.search=', this.$site.themeConfig.search);
    this.checkDebugQueryParam();
  },
  methods: {
    checkDebugQueryParam() {
      if (this.$route.query && this.$route.query["debug"] && this.$route.query["debug"] === 'true') {
        // https://gist.github.com/addyosmani/fd3999ea7fce242756b1
        const empty = [];
        empty.forEach.call(document.querySelectorAll("*"), function (a) { a.style.outline = "1px solid #" + (~~(Math.random() * (1 << 24))).toString(16) });
      }
    },
  },
}
</script>

<style lang="stylus">
$navbar-vertical-padding = 0.7rem
$navbar-horizontal-padding = 1.5rem

.navbar {
  .home-link {
    display: block;
    // display: flex;
    // flex-direction: column;
    // align-items: start;
    // max-height: "calc((%s - %s) / 2)" % ($navbarHeight ($navbar-vertical-padding));
    height: "calc(%s - (%s * 2))" % ($navbarHeight ($navbar-vertical-padding));
  }

  .site-name {
    display: block;
    height: "calc((%s - (%s * 2)) / 2)" % ($navbarHeight ($navbar-vertical-padding));
    max-height: "calc((%s - (%s * 2)) / 2)" % ($navbarHeight ($navbar-vertical-padding));
    line-height: 5.6rem;
  }

  .logo {
    display: block;
    height: "calc(%s - (%s * 2) / 2)" % ($navbarHeight ($navbar-vertical-padding));
    max-height: "calc((%s - (%s * 2)) / 2)" % ($navbarHeight ($navbar-vertical-padding));
    // height: 30% !important;
    // max-height: 30% !important;
    // width: $navbarHeight - 1.4rem;
    // max-width: $navbarHeight - 1.4rem;
  }

  // .links {
  //   height: "calc(%s - (%s * 2) / 2)" % ($navbarHeight ($navbar-vertical-padding));
  //   max-height: "calc((%s - (%s * 2)) / 2)" % ($navbarHeight ($navbar-vertical-padding));
  // }
}

// .navbar {
//   a {
//     display: block;
//   }

//   .logo {
//     height: $navbarHeight / 2;
//     // height: 30% !important;
//     // max-height: 30% !important;
//     max-height: $navbarHeight / 10;
//     display: inline-block;
//   }
// }
// @import url('https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&display=swap&subset=cyrillic,cyrillic-ext,greek,greek-ext,latin-ext,vietnamese');

// .navbar {
//   a {
//     display: block;
//   }

//   // min-height: 5.6rem;
//   .logo {
//     // height: 30% !important;
//     // max-height: 30% !important;
//     max-height: 2.2rem;
//     display: block;
//   }

//   // Make search appear beneath navbar links.
//   √
//     box-sizing: content-box;
//     flex-direction: column-reverse;

//     .search-box {
//       flex-direction: row;
//       // align-content: stretch;
//       display: flex;

//       input {
//         flex: 1;
//         align-items: flex-end;
//       }

//       .suggestions {
//         width: unset;
//       }
//     }

//     .search-box:first-child {
//       margin-right: 0;
//     }

//     .nav-links {
//       // max-width: inherit;

//       // overflow-x: overlay;
//       // flex-wrap: wrap;
//       // display: flex;
//       a {
//         color: #283973;
//         // color: #2ea3f2; // active colour for `API Specifications`.
//         font-family: 'Open Sans', 'Arial', sans-serif;
//         font-weight: bold;
//         font-style: normal;
//         text-transform: none;
//         text-decoration: none;
//       }
//     }
//   }
// }

// @media (max-width: 719px) {
//   .navbar .logo {
//     // height: 2.2rem;
//     // max-height: 30% !important;
//     // display: none;
//   }
// }

// @media (max-width: 719px) {
//   .navbar .links .search-box .suggestions {
//     width: 20rem;
//   }
// }
</style>
