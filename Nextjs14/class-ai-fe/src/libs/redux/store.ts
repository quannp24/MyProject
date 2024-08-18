import { configureStore } from "@reduxjs/toolkit";
import loadingSlice from "./loadingSlice";
import breadcrumbsSlice from "./breadcrumbsSlice";

export const store = configureStore({
  reducer: {
    loading: loadingSlice,
    breadcrumbs: breadcrumbsSlice
  },
});