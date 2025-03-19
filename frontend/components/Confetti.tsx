'use client';
import React, { useEffect, useRef } from 'react';

interface ConfettiProps {
  show: boolean;
  targetId: string;
}

// confetti fonksiyonu için bir tip tanımı (eğer @tsparticles/confetti paketi tip tanımları sağlamıyorsa)
declare function confetti(container: HTMLElement | null, options?: any): void;

const Confetti: React.FC<ConfettiProps> = ({ show, targetId }) => {
  const containerRef = useRef<HTMLDivElement>(null); // Konteyner için bir ref (kullanılmıyor, ama script yüklemesi için gerekli)
  const scriptRef = useRef<HTMLScriptElement | null>(null); // Script elementi için bir ref

  useEffect(() => {
    let interval: NodeJS.Timeout | undefined; // interval için null'ı da kabul eden bir tip

    if (show) {
      const script = document.createElement('script');
      script.src = 'https://cdn.jsdelivr.net/npm/@tsparticles/confetti@3.0.3/tsparticles.confetti.bundle.min.js';
      script.async = true;
      scriptRef.current = script; // Script elementini ref'e kaydet
      document.body.appendChild(script);

      script.onload = () => {
        const container = document.getElementById(targetId);
        if (!container) {
          console.error(`Element with ID "${targetId}" not found.`);
          return;
        }

        const duration = 15 * 1000;
        const animationEnd = Date.now() + duration;
        const defaults = { startVelocity: 30, spread: 360, ticks: 60, zIndex: 1000 };

        function randomInRange(min: number, max: number): number { // Tip belirlemesi
          return Math.random() * (max - min) + min;
        }

        interval = setInterval(() => {
          const timeLeft = animationEnd - Date.now();

          if (timeLeft <= 0) {
            clearInterval(interval);
            interval = undefined; // interval'i temizle
            return;
          }

          const particleCount = 50 * (timeLeft / duration);

            confetti(container,
              Object.assign({}, defaults, {
                particleCount,
                origin: { x: randomInRange(0.1, 0.3), y: Math.random() - 0.2 },
              })
            );
            confetti(container,
              Object.assign({}, defaults, {
                particleCount,
                origin: { x: randomInRange(0.7, 0.9), y: Math.random() - 0.2 },
              })
            );
        }, 500);
      };

      return () => {
        clearInterval(interval);
        if (scriptRef.current && scriptRef.current.parentNode) {
          document.body.removeChild(scriptRef.current);
        }
        scriptRef.current = null; // Ref'i temizle
      };
    } else {
      // Eğer show false ise, interval'i ve script'i temizle (önlem)
      clearInterval(interval);
        if (scriptRef.current && scriptRef.current.parentNode) {
            document.body.removeChild(scriptRef.current);
        }
      scriptRef.current = null;
    }
  }, [show, targetId]);

  return <div ref={containerRef}></div>;
};

export default Confetti;