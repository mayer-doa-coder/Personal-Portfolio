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
    animateSkillBars();
    setupContactMeButton();
    initSmoothTransitions();
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

    document.querySelectorAll('.navigation-link').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const targetId = link.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            if (targetSection) {
                targetSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

// Contact Me button
function setupContactMeButton() {
    const contactMeButton = document.querySelector('.btn-contact-info');
    
    if (contactMeButton) {
        contactMeButton.addEventListener('click', function() {
            document.querySelector('#contact').scrollIntoView({ behavior: 'smooth' });
        });
    }
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
