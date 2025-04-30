import { logoutAction } from "@/app/data/actions/auth-actions";
import { LogOut } from "lucide-react";

export function LogoutButton() {
  return (
    <form action={logoutAction}>
      <button className="flex flex-row gap-2 items-center cursor-pointer" type="submit">
        <LogOut className="w-4 h-4 hover:text-primary" /> Logga ut
      </button>
    </form>
  );
}