import React, { ReactNode, MouseEventHandler } from 'react';

interface TesdiqButtonProps {
  onClick: MouseEventHandler<HTMLButtonElement>;
  children: ReactNode;
  className?: string;
  disabled?: boolean;
}

const TesdiqButton: React.FC<TesdiqButtonProps> = ({ onClick, children, className, disabled = false }) => {
  const buttonClasses = `bg-main rounded text-gray-800 py-3 px-6 font-bold text-xl hover:bg-opacity-75 transition-colors ${className}`;

  return (
    <button
      className={buttonClasses}
      onClick={onClick} 
      disabled={disabled}
    >
      {children}
    </button>
  );
};

export default TesdiqButton;
