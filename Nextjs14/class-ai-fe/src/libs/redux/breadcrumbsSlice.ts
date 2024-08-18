import { createSlice, PayloadAction } from '@reduxjs/toolkit';

interface BreadcrumbsState {
  breadcrumbs: BreadCrumbs[];
}

const initialState: BreadcrumbsState = {
  breadcrumbs: [],
};

const breadcrumbsSlice = createSlice({
  name: 'breadcrumbs',
  initialState,
  reducers: {
    setBreadcrumbs: (state, action: PayloadAction<BreadCrumbs[]>) => {
      state.breadcrumbs = action.payload;
    },
    clearBreadcrumbs: (state) => {
      state.breadcrumbs = [];
    },
    addBreadcrumb: (state, action: PayloadAction<BreadCrumbs>) => {
      state.breadcrumbs.push(action.payload);
    },
  },
});

export const { setBreadcrumbs, clearBreadcrumbs, addBreadcrumb } = breadcrumbsSlice.actions;

export default breadcrumbsSlice.reducer;
