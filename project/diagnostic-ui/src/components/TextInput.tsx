import { FC, ReactNode, memo } from "react";
import { IoIosLock } from "react-icons/io";

interface Props extends React.InputHTMLAttributes<HTMLInputElement> {
  className?: string;
  Icon?: ReactNode;
}

const TextInput: FC<Props> = memo(
  ({ Icon = <IoIosLock size={25} />, className, ...props }) => {
    return (
      <div
        className={`flex py-1 rounded-lg bg-main-blue text-white items-center ${className} outline outline-0 outline-white focus-within:outline-2`}
      >
        <div className="flex pl-1 pr-1 justify-center items-center">{Icon}</div>
        <div className="flex flex-1 pr-1 items-center">
          <input
            type="text"
            className={`pl-1 pr-2 w-full outline-none bg-transparent text-base rounded-sm`}
            {...props}
          />
        </div>
      </div>
    );
  }
);

export default TextInput;
