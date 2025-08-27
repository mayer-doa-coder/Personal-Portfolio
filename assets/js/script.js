// Typewriter effect
const typewriterText = document.querySelector('.personal-info-typewriter');
const texts = ['Student', 'Web Developer', 'Programmer', 'Content Designer'];
let textIndex = 0;
let charIndex = 0;
let isDeleting = false;

function typeWriter() {
    const currentText = texts[textIndex];
    
    if (isDeleting) {
        typewriterText.textContent = currentText.substring(0, charIndex - 1);
        charIndex--;
    } else {
        typewriterText.textContent = currentText.substring(0, charIndex + 1);
        charIndex++;
    }
    
    if (!isDeleting && charIndex === currentText.length) {
        setTimeout(() => isDeleting = true, 1000);
    } else if (isDeleting && charIndex === 0) {
        isDeleting = false;
        textIndex = (textIndex + 1) % texts.length;
    }
    
    setTimeout(typeWriter, isDeleting ? 40 : 80);
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    typeWriter();
    setupContactMeButton();
    
    // Delayed initialization to avoid conflicts
    setTimeout(() => {
        animateSkillBars();
        initSmoothTransitions();
    }, 100);

    setTimeout(() => {
        initParallaxEffect();
        initTextRevealEffect();
        initFloatingElements();
        initElegantCardEffects();
    }, 500);
});

// Smooth transitions
function initSmoothTransitions() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-fade-up');
            }
        });
    }, observerOptions);

    document.querySelectorAll('section, .project-item, .achievement-item').forEach(el => {
        el.classList.add('animate-hidden');
        observer.observe(el);
    });
    initSmoothScrolling();
}

// Enhanced Smooth Scrolling Implementation
function initSmoothScrolling() {

    function smoothScrollTo(targetElement, duration = 500) {
        const targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset;
        const startPosition = window.pageYOffset;
    
        let offset = 80;
        const sectionId = targetElement.getAttribute('id');
        
        // Special handling for contact section to prevent position shift
        if (sectionId === 'contact') {
            offset = 60; 
        } else if (sectionId === 'home') {
            offset = 0; 
        }
        
        const distance = targetPosition - startPosition - offset;
        let startTime = null;

        // Faster easing function for quicker response
        function easeOutQuart(t) {
            return 1 - (--t) * t * t * t;
        }

        function animation(currentTime) {
            if (startTime === null) startTime = currentTime;
            const timeElapsed = currentTime - startTime;
            const progress = Math.min(timeElapsed / duration, 1);
            
            const easedProgress = easeOutQuart(progress);
            window.scrollTo(0, startPosition + distance * easedProgress);
            
            if (timeElapsed < duration) {
                requestAnimationFrame(animation);
            }
        }

        requestAnimationFrame(animation);
    }

    // Handle all navigation links (header, footer, signature)
    const allNavLinks = document.querySelectorAll('.navigation-link, .footer-link, .signature a');
    
    allNavLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const targetId = link.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            if (targetSection) {
                updateActiveNavigation(targetId);
                smoothScrollTo(targetSection, 400);
                addScrollFeedback(link);
            }
        });
    });

    // Handle contact button smooth scrolling
    const contactMeButton = document.querySelector('.btn-contact-info');
    if (contactMeButton) {
        contactMeButton.addEventListener('click', (e) => {
            e.preventDefault();
            const contactSection = document.querySelector('#contact');
            if (contactSection) {
                updateActiveNavigation('#contact');
                smoothScrollTo(contactSection, 400);
                addScrollFeedback(contactMeButton);
            }
        });
    }

    // Update active navigation based on scroll position
    window.addEventListener('scroll', updateActiveNavigationOnScroll);
}

// Update active navigation state
function updateActiveNavigation(targetId) {
    document.querySelectorAll('.navigation-link, .footer-link').forEach(link => {
        link.classList.remove('active');
    });
    
    // Add active class to current links
    document.querySelectorAll(`a[href="${targetId}"]`).forEach(link => {
        if (link.classList.contains('navigation-link') || link.classList.contains('footer-link')) {
            link.classList.add('active');
        }
    });
}

// Update active navigation on scroll
function updateActiveNavigationOnScroll() {
    const sections = document.querySelectorAll('section[id]');
    const scrollPos = window.pageYOffset + 100;

    sections.forEach(section => {
        const top = section.getBoundingClientRect().top + window.pageYOffset;
        const bottom = top + section.offsetHeight;
        const sectionId = '#' + section.getAttribute('id');

        if (scrollPos >= top && scrollPos <= bottom) {
            updateActiveNavigation(sectionId);
        }
    });
}

// Add visual feedback for clicks
function addScrollFeedback(element) {
    element.style.transform = 'scale(0.95)';
    element.style.transition = 'transform 0.05s ease';
    
    setTimeout(() => {
        element.style.transform = 'scale(1)';
        setTimeout(() => {
            element.style.transition = '';
        }, 50);
    }, 50);
}

// Contact Me button - handled in initSmoothScrolling
function setupContactMeButton() {

}

// Skill bars animation
function animateSkillBars() {
    const skillBars = document.querySelectorAll('.skill-progress');
    
    skillBars.forEach((bar, index) => {
        const targetWidth = bar.getAttribute('data-width');
        setTimeout(() => {
            bar.style.width = targetWidth;
        }, index * 200);
    });
}

// Back to top button
window.addEventListener('scroll', function() {
    const backToTopButton = document.getElementById('backToTop');
    
    if (window.pageYOffset > 300) {
        backToTopButton.classList.add('show');
    } else {
        backToTopButton.classList.remove('show');
    }
});

document.getElementById('backToTop').addEventListener('click', function() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
});

// Parallax effect for background elements
function initParallaxEffect() {
    window.addEventListener('scroll', () => {
        const scrolled = window.pageYOffset;
        
        // Only apply parallax after initial load and when scrolled
        if (scrolled > 50) {
            const sections = document.querySelectorAll('.about-me, .skills');
            sections.forEach((section, index) => {
                const speed = (index + 1) * 0.05; // Reduced speed
                section.style.transform = `translateY(${scrolled * speed}px)`;
            });
        }
        
        // Dynamic header opacity based on scroll
        const header = document.querySelector('.header');
        const opacity = Math.max(0.7, 1 - scrolled / 500);
        header.style.background = `rgba(10, 14, 39, ${opacity})`;
    });
}

// Elegant card effects
function initElegantCardEffects() {
    const cards = document.querySelectorAll('.project-item, .achievement-item, .timeline-content');
    
    cards.forEach(card => {
        // Add ripple effect on click
        card.addEventListener('click', function(e) {
            createRippleEffect(e, this);
        });
        
        // Add subtle scale and glow on hover
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px) scale(1.02)';
            this.style.boxShadow = '0 20px 40px rgba(0, 212, 255, 0.2)';
            this.style.borderColor = 'rgba(0, 212, 255, 0.5)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
            this.style.boxShadow = '';
            this.style.borderColor = '';
        });
        
        // Add loading shimmer effect on scroll into view
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('card-shimmer');
                    setTimeout(() => {
                        entry.target.classList.remove('card-shimmer');
                    }, 1500);
                }
            });
        }, { threshold: 0.3 });
        
        observer.observe(card);
    });
}

// Create ripple effect
function createRippleEffect(event, element) {
    const ripple = document.createElement('div');
    ripple.className = 'ripple-effect';
    
    const rect = element.getBoundingClientRect();
    const size = Math.max(rect.width, rect.height);
    const x = event.clientX - rect.left - size / 2;
    const y = event.clientY - rect.top - size / 2;
    
    ripple.style.width = ripple.style.height = size + 'px';
    ripple.style.left = x + 'px';
    ripple.style.top = y + 'px';
    
    element.style.position = 'relative';
    element.style.overflow = 'hidden';
    element.appendChild(ripple);
    
    setTimeout(() => {
        ripple.remove();
    }, 600);
}

// Text reveal animation with intersection observer
function initTextRevealEffect() {
    // Only apply to specific sections, not the home section
    const textElements = document.querySelectorAll('.about-me h2, .about-me p, .achievements-section h3, .achievements-section h4, .education-section h3');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('text-reveal');
            }
        });
    }, { threshold: 0.1 });
    
    textElements.forEach(el => {
        el.classList.add('text-hidden');
        observer.observe(el);
    });
}

// Floating animation for decorative elements
function initFloatingElements() {
    // Create floating particles
    const particleContainer = document.createElement('div');
    particleContainer.className = 'floating-particles';
    document.body.appendChild(particleContainer);
    
    for (let i = 0; i < 6; i++) {
        const particle = document.createElement('div');
        particle.className = 'floating-particle';
        particle.style.left = Math.random() * 100 + '%';
        particle.style.animationDelay = Math.random() * 10 + 's';
        particle.style.animationDuration = (Math.random() * 10 + 15) + 's';
        particleContainer.appendChild(particle);
    }
}

// Enhanced scroll-triggered animations
function initEnhancedScrollAnimations() {
    const elements = document.querySelectorAll('.skill-item, .contact-item');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry, index) => {
            if (entry.isIntersecting) {
                setTimeout(() => {
                    entry.target.classList.add('slide-in-animation');
                }, index * 100);
            }
        });
    }, { threshold: 0.3 });
    
    elements.forEach(el => observer.observe(el));
}

// Call enhanced animations
document.addEventListener('DOMContentLoaded', function() {
    setTimeout(initEnhancedScrollAnimations, 1000);
});

// Sophisticated page load animation
function initPageLoadAnimation() {
    // Create loading overlay
    const loadingOverlay = document.createElement('div');
    loadingOverlay.className = 'page-loading-overlay';
    loadingOverlay.innerHTML = `
        <div class="loading-content">
            <div class="loading-text">Welcome</div>
            <div class="loading-bar">
                <div class="loading-progress"></div>
            </div>
        </div>
    `;
    document.body.appendChild(loadingOverlay);
    
    // Animate loading faster
    setTimeout(() => {
        const progressBar = document.querySelector('.loading-progress');
        if (progressBar) {
            progressBar.style.width = '100%';
        }
    }, 200);
    
    // Remove loading overlay quickly
    setTimeout(() => {
        loadingOverlay.style.opacity = '0';
        setTimeout(() => {
            if (loadingOverlay.parentNode) {
                loadingOverlay.remove();
            }
            document.body.classList.add('page-loaded');
        }, 300);
    }, 800);
}
