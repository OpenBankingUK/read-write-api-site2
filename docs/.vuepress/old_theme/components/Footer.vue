<template>
  <footer class="page-edit footer">
    <div class="footer-navigation">
      <ul>
        <li>
          <a href="https://www.openbanking.org.uk/about-us/">About Us</a>
        </li>
        <li>
          <a href="https://www.openbanking.org.uk/">Customers</a>
        </li>
        <li>
          <a href="https://www.openbanking.org.uk/providers/">Providers</a>
        </li>
        <li>
          <a href="https://www.openbanking.org.uk/contact-us/">Contact Us</a>
        </li>
        <li>
          <a href="https://www.openbanking.org.uk/terms-conditions/">Terms and Conditions</a>
        </li>
        <li>
          <a href="https://www.openbanking.org.uk/privacy-policy/">Privacy Policy</a>
        </li>
        <li>
          <a href="https://www.openbanking.org.uk/cookies/">Cookies</a>
        </li>
        <li>
          <a href="https://www.openbanking.org.uk/accessibility/">Accessibility</a>
        </li>
        <li>
          <a href="https://www.openbanking.org.uk/open-licence/">Open Licence</a>
        </li>
      </ul>
    </div>
    <div class="footer-info">
      <p>© Copyright Open Banking Limited 2019.</p>
      <p>Registered in England. Company Number: 10440081</p>
      <p>Registered office: 2 Thomas More Square, London E1W 1YN United Kingdom</p>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'Footer',
};
</script>

<style lang="stylus">
.footer {
  // font-family: 'Open Sans', 'Arial', sans-serif;
  background-color: #313436;
  display: flex;
  flex-direction: column;
  align-items: stretch;
}

.footer-navigation {
  display: flex;
  flex-direction: row;
  color: #6180c3;

  ul {
    padding-left: 0;
  }

  li {
    display: inline;
    padding-left: 0.5rem;
    padding-right: 0.5rem;
    border-right: 1px solid #ffffff;
    // font-size: 14px;
    // font-weight: 600;
    // border-right: 1px solid rgba(97, 128, 195, .2);
  }

  li:first-child {
    padding-left: 0;
  }

  li:last-child {
    border-right: 0;
    padding-right: 0;
  }

  a {
    // font-size: 18px;
  }
}

.footer-info {
  display: flex;
  flex-direction: column;
  color: #ffffff;
}
</style>
