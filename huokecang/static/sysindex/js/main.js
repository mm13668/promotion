/* ========== 获客仓 - 主脚本 ========== */

$(function () {

  // --- Smooth scroll & nav active ---
  $('.page-scroll').on('click', function (e) {
    var target = $(this).attr('href');
    if (target && target.startsWith('#')) {
      e.preventDefault();
      $('html, body').animate({ scrollTop: $(target).offset().top - 70 }, 600);
      $('#hkc-nav').collapse('hide');
    }
  });

  $(window).on('scroll', function () {
    var scrollPos = $(window).scrollTop() + 100;
    $('.page-scroll').each(function () {
      var href = $(this).attr('href');
      if (href && href.startsWith('#')) {
        var section = $(href);
        if (section.length) {
          $(this).toggleClass('active', section.offset().top <= scrollPos &&
            section.offset().top + section.height() > scrollPos);
        }
      }
    });
  });

  // --- Typewriter effect ---
  var TxtType = function (el, toRotate, period) {
    this.toRotate = toRotate;
    this.el = el;
    this.loopNum = 0;
    this.period = parseInt(period, 10) || 2000;
    this.txt = '';
    this.tick();
    this.isDeleting = false;
  };

  TxtType.prototype.tick = function () {
    var i = this.loopNum % this.toRotate.length;
    var fullTxt = this.toRotate[i];

    if (this.isDeleting) {
      this.txt = fullTxt.substring(0, this.txt.length - 1);
    } else {
      this.txt = fullTxt.substring(0, this.txt.length + 1);
    }

    this.el.innerHTML = '<span class="wrap">' + this.txt + '</span>';

    var that = this;
    var delta = 200 - Math.random() * 100;

    if (this.isDeleting) { delta /= 2; }

    if (!this.isDeleting && this.txt === fullTxt) {
      delta = this.period;
      this.isDeleting = true;
    } else if (this.isDeleting && this.txt === '') {
      this.isDeleting = false;
      this.loopNum++;
      delta = 500;
    }

    setTimeout(function () { that.tick(); }, delta);
  };

  var typewriteEl = document.querySelector('.typewrite');
  if (typewriteEl && typewriteEl.getAttribute('data-type')) {
    var period = typewriteEl.getAttribute('data-period');
    var data = JSON.parse(typewriteEl.getAttribute('data-type'));
    if (data.length) {
      new TxtType(typewriteEl, data, period);
    }
  }

  // --- Counter animation ---
  function animateCounter(el) {
    var target = parseFloat(el.getAttribute('data-target'));
    if (isNaN(target)) return;
    var current = 0;
    var increment = target / 60;
    var timer = setInterval(function () {
      current += increment;
      if (current >= target) {
        el.textContent = target;
        clearInterval(timer);
      } else {
        el.textContent = target < 100 ? current.toFixed(1) : Math.floor(current);
      }
    }, 25);
  }

  var counterObserved = false;
  var counterObserver = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting && !counterObserved) {
        counterObserved = true;
        $('.counter').each(function () { animateCounter(this); });
      }
    });
  }, { threshold: 0.5 });

  var statsSection = document.querySelector('.stats-section');
  if (statsSection) counterObserver.observe(statsSection);

  // --- Scroll animations ---
  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) {
        entry.target.classList.add('fadeInUp');
      }
    });
  }, { threshold: 0.15 });

  document.querySelectorAll('.ftco-animate').forEach(function (el) {
    observer.observe(el);
  });

  // --- FAQ toggle ---
  $('.faq-item').on('click', function () {
    $(this).toggleClass('open');
    $(this).find('.faq-answer').slideToggle(200);
  });

  // --- Owl Carousel ---
  if ($('.hero-carousel').length) {
    $('.hero-carousel').owlCarousel({
      items: 1,
      loop: true,
      margin: 0,
      nav: false,
      dots: true,
      autoplay: true,
      autoplayTimeout: 4000,
      smartSpeed: 600,
      animateOut: 'fadeOut',
      animateIn: 'fadeIn'
    });
  }
});
