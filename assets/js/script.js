// Typewriter effect for personal info section
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
        setTimeout(() => {
            isDeleting = true;
        }, 1000); // Wait 1 second before deleting
    } else if (isDeleting && charIndex === 0) {
        isDeleting = false;
        textIndex = (textIndex + 1) % texts.length;
    }
    
    const typingSpeed = isDeleting ? 40 : 80;
    setTimeout(typeWriter, typingSpeed);
}

// Start typewriter effect when page loads
document.addEventListener('DOMContentLoaded', function() {
    typeWriter();
});

// Back to Top Button Functionality
window.addEventListener('scroll', function() {
    const backToTopButton = document.getElementById('backToTop');
    
    if (window.pageYOffset > 300) {
        backToTopButton.classList.add('show');
    } else {
        backToTopButton.classList.remove('show');
    }
});

// Smooth scroll to top when button is clicked
document.getElementById('backToTop').addEventListener('click', function() {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});
