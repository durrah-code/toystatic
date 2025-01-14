import { Outlet } from "react-router-dom";
import Navbar from "./components/Navbar";
import FlashMessage from "./components/FlashMessage";
import { useDispatch, useSelector } from "react-redux";
import { actions } from "../store";

function Layout() {
    const flashMessage = useSelector((state) => state.flashMessage);
    const dispatch = useDispatch();

    const handleFlashClose = () => {
        dispatch(actions.setFlashMessage(null));
    };

    return (
        <>
            <div style={{ position: "fixed", width: "100%", top: 0, zIndex: 1000 }}>
                <Navbar />
            </div>
            {/* Flash Message */}
            {flashMessage && <FlashMessage message={flashMessage} onClose={handleFlashClose} />}

            {/* Main content area */}
            <div style={{ marginTop: "140px", padding: "20px" }}>
                <Outlet /> {/* This is where the child routes will render */}
            </div>
        </>
    );
}

export default Layout;
