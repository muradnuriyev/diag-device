import { FC, HTMLAttributes, memo } from "react";

const Button: FC<HTMLAttributes<HTMLButtonElement>> = memo(
  ({ className, children, ...props }) => {
    return (
      <button
        type="button"
        className={`outline outline-0 outline-white focus:outline-2 active:outline-2 bg-main-blue text-white px-8 py-1 rounded-lg ${className}`}
        {...props}
      >
        {children}
      </button>
    );
  }
);

export default Button;
