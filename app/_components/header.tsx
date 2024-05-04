import { MenuIcon } from "lucide-react";
import Image from "next/image";
import { Button } from "./ui/button";

const Header = () => {
  return (
    <div className="p flex justify-between px-5 pt-6">
      <Image src="/logo.png" alt="FSW Foods" height={30} width={100} />
      <Button size="icon" variant="ghost">
        <MenuIcon />
      </Button>
    </div>
  );
};

export default Header;
